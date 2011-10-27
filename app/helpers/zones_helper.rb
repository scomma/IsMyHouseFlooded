module ZonesHelper
  def populate_data_table levels
    last_level = "null"
    """
    data.addColumn('string', 'Time');
    data.addColumn('number', 'Level');
    data.addRows(#{levels.size});
    """ +
    levels.zip(0...levels.size).collect do |level, index|
      label = case level.at_ict.hour
                when 0         then level.at_ict.strftime "[%d %b]"
                when 6, 12, 18 then level.at_ict.strftime "%H:%M"
              end
      last_level = level.level || last_level
      """
      data.setCell(#{index}, 0, '#{label}')
      data.setCell(#{index}, 1, #{last_level})
      """
    end.join
  end
end
