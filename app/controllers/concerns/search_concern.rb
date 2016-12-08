module SearchConcern
  extend ActiveSupport::Concern

  def chain_where_like(arel, field, value)
    return arel if value.blank?

    if value.start_with? 'NOT '
      return arel.where.not("unaccent(#{field}) ILIKE unaccent(?)", "%#{value.sub('NOT ', '')}%")
    else
      return arel.where("unaccent(#{field}) ILIKE unaccent(?)", "%#{value}%")
    end
  end

  def split_tags_pos_neg(tags)
    pos_tags = tags.select {|x|  !x.start_with?('NOT ')}
    neg_tags = tags.select {|x|  x.start_with?('NOT ')}
    neg_tags = neg_tags.map {|x| x.sub('NOT ', '')}
    return pos_tags, neg_tags
  end

  def define_where_fragment_like_pos_neg(field, pos_tags, neg_tags)
    sql = ""
    opts = []
    sep = ""
    pos_tags.each do |t|
      sql += "#{sep}(#{field} ILIKE ?)"
      sep = " AND "
      opts.append "%#{t}%"
    end 
    neg_tags.each do |t|
      sql += "#{sep}(#{field} NOT ILIKE ?)"
      sep = " AND "
      opts.append "%#{t}%"
    end
    return sql, opts
  end

  def define_where_fragment_array_pos_neg(field, pos_tags, neg_tags)
    opts = []
    sql = ""

    ps = define_where_fragment_array(field, pos_tags)
    ns = define_where_fragment_array(field, neg_tags)

    if ps.blank? and ns.blank?
      return "", []
    elsif ps.blank?
      return "NOT #{ns}", [neg_tags]
    elsif ns.blank?
      return ps, [pos_tags]
    else
      return  "(#{ps}) AND (NOT #{ns})", [pos_tags, neg_tags]
    end
  end

  def define_where_fragment_array(field, tags)
    return "" if tags.blank?

    return "#{field} && ARRAY[?]::varchar[]"
  end
end
