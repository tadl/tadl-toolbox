module ReportsHelper
  def check_for_value(code, reports)
    stat_id = Stat.where(code: code).first.id 
    value = reports.where(stat_id: stat_id).first.value rescue nil
    return value
  end

  def check_for_report_on_date(date, department_id)
    reports = Report.where(department_id: department_id, report_date: date).first
    if !reports.nil?
      return '; font-weight: 900; font-size: 14px;'
    else
      return nil
    end
  end

end