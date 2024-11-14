class DirectorsController < ApplicationController
  def index
    matching_directors = Director.all
    @list_of_directors = matching_directors.order({ :created_at => :desc })

    render({ :template => "director_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_directors = Director.where({ :id => the_id })
    @the_director = matching_directors.at(0)

    render({ :template => "director_templates/show" })
  end

  def max_dob
    directors_by_dob_desc = Director.
      all.
      where.not({ :dob => nil }).
      order({ :dob => :desc })

    @youngest = directors_by_dob_desc.at(0)

    render({ :template => "director_templates/youngest" })
  end

  def min_dob
    directors_by_dob_asc = Director.
      all.
      where.not({ :dob => nil }).
      order({ :dob => :asc })
      
    @eldest = directors_by_dob_asc.at(0)

    render({ :template => "director_templates/eldest" })
  end

  def create
    d=Director.new
    d.name=params.fetch("name")
    d.bio=params.fetch("bio")
    d.dob=params.fetch("dob")
    d.image=params.fetch("image")
    d.save
    redirect_to("/directors") #error says key already duplicated

  end

  def delete
    the_id=params.fetch("an_id")
    matching_record=Director.where({:id=>the_id})
    director=matching_record.at(0)
    director.destroy
    redirect_to("/directors")
  end

  def update
    the_id=params.fetch("the_id")
    matching_record=Director.where ({:id=>the_id})
    director=matching_record.at(0)
    director.name=params.fetch("name")
    director.bio=params.fetch("bio")
    director.dob=params.fetch("dob")
    director.image=params.fetch("image")
    director.save
    redirect_to("/directors/#{director.id}")

  end
end
