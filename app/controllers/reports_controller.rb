class ReportsController < ApplicationController
  before_action :authenticate_user!

  # GET /reports
  # GET /reports.json
  def index
    @departments = Department.all
  end

  def show_calendar
    @department = Department.find(params[:department_id])
    respond_to do |format|
      format.js
    end
  end

  def show_report_form
    @department = Department.find(params[:department_id])
    @date = params[:date]
    report_date = Date.parse params[:date]
    @reports = Report.where(department_id: @department.id, report_date: report_date)
    @reports.each do |r|
      puts r.value.to_s
    end
    respond_to do |format|
      format.js
    end
  end


  def save_report
    @stats = Stat.all
    @submitted_stats = []
    params.each do |k,v|
      if @stats.pluck(:code).include?(k)
        stat = Stat.where(code: k).take
        report = Report.where(stat_id: stat.id, department_id: params[:department_id], report_date: params[:report_date]).take
        if !report.nil? 
          report.update(report_params)
          report.value = v
          report.save
        else
          report = Report.new(report_params)
          report.value = v
          report.stat_id = stat.id
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
