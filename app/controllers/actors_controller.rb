class ActorsController < ApplicationController
  def index
    matching_actors = Actor.all
    @list_of_actors = matching_actors.order({ :created_at => :desc })

    render({ :template => "actor_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_actors = Actor.where({ :id => the_id })
    @the_actor = matching_actors.at(0)
      
    render({ :template => "actor_templates/show" })
  end

  def create
    a=Actor.new
    a.name=params.fetch("name")
    a.dob=params.fetch("dob")
    a.bio=params.fetch("bio")
    a.image=params.fetch("image")
    a.save
    redirect_to("/actors")
  end

  def delete
    the_id=params.fetch("an_id")
    matching_record=Actor.where({:id => the_id})
    the_actor=matching_record.at(0)
    the_actor.destroy
    redirect_to("/actors")
  end
end
