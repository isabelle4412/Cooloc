class TeamTasksController < ApplicationController
  def new
    @team_task = TeamTask.new
    @tasks = Task.all
  end

  def create
    @team = current_user.team
    @team.task_ids = team_param
    if @team.save!
      redirect_to chores_path, notice: 'Tes tâches sont bien enregistrées ! '
      BuildTeamMonthlyPlanningService.new(@team).call
    else
      render :new
    end
  end

  private

  def team_param
    params.require(:team_task).permit(:task_id)
  end
end
