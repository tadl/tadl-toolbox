class ReportsController < ApplicationController
  before_action :authenticate_user!

  # GET /reports
  # GET /reports.json
  def index
    @departments = Department.all
  end

  def show_calendar
    @department = Department.find(params[:department_id])
    if params[:start_date]
        day = Date.parse(params[:start_date])
    else
        day = Date.today
    end
    start_date = Date.new(day.year, day.month - 1, 1).to_date
    end_date = Date.new(day.year, day.month + 1, -1).to_date
    @reports = Report.where("department_id = ? AND report_date >= ? AND report_date <= ?", @department.id, start_date, end_date).to_a
    respond_to do |format|
      format.js
    end
  end

  def show_report_form
    @department = Department.find(params[:department_id])
    @date = params[:date]
    report_date = Date.parse params[:date]
    @reports = Report.where(department_id: @department.id, report_date: report_date).to_a
    respond_to do |format|
      format.js
    end
  end


  def save_report
    @stats = Stat.all
    params.each do |k,v|
      if @stats.pluck(:code).include?(k)
        stat = @stats.where(code: k).take
        report = Report.where(stat_id: stat.id, department_id: params[:department_id], report_date: params[:report_date]).first
        if !report.nil?
          if v != '0'
            report.update(report_params)
            report.value = v
            report.last_edit_by = Admin.find(params[:last_edit_by].to_i).email
            report.save
          else
            report.destroy
          end
        elsif v != '0'
          report = Report.new(report_params)
          report.stat_id = stat.id
          report.value = v
          report.last_edit_by = Admin.find(params[:last_edit_by].to_i).email
          report.save
        end
      end
    end
    respond_to do |format|
      format.js
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def report_params
      params.permit(:stat_id, :value, :last_edit_by, :department_id, :report_date)
    end
end
