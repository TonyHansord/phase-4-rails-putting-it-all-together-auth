class RecipesController < ApplicationController
  # before_action :authorize, only: :create

  def index
    recipes = Recipe.all
    render json: recipes, include: :user
  end

  def create
    recipe = @current_user.recipes.create(recipe_params)
    if recipe.valid?
      render json: recipe, include: :user, status: :created
    else
      render json: { errors: recipe.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def recipe_params
    params.permit(:user_id, :title, :instructions, :minutes_to_complete)
  end
end
