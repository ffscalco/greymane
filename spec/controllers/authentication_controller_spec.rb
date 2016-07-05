require 'rails_helper'

class AuthenticationController < ApplicationController; end
class Authentication < ActiveRecord::Base; end

RSpec.describe AuthenticationController, type: :controller do
  controller do
    def index
      render :nothing => true
    end
    def new
      render :nothing => true
    end
    def create
      render :nothing => true
    end
    def edit
      render :nothing => true
    end
    def update
      render :nothing => true
    end
    def destroy
      render :nothing => true
    end
  end

  context "When not logged in" do
    it "redirect to new user session when try to access index" do
      get :index
      expect(response).to redirect_to(root_path)
    end

    it "redirect to new user session when try to access new" do
      get :new
      expect(response).to redirect_to(root_path)
    end

    it "redirect to new user session when try to access edit" do
      get :edit, {:id => 1}
      expect(response).to redirect_to(root_path)
    end

    it "redirect to new user session when try to access create" do
      post :create, {:post => {some: :attribute}}
      expect(response).to redirect_to(root_path)
    end

    it "redirect to new user session when try to access update" do
      put :update, {:id => 1, :post => {some: :attribute}}

      expect(response).to redirect_to(root_path)
    end

    it "redirect to new user session when try to access destroy" do
      delete :destroy, {:id => 1}

      expect(response).to redirect_to(root_path)
    end
  end

  context "When logged in" do
    before do
      sign_in(FactoryGirl.create(:user))
    end

    it "access index" do
      get :index
      expect(response.code).to eq("200")
    end

    it "access new" do
      get :new
      expect(response.code).to eq("200")
    end

    it "access edit" do
      get :edit, {:id => 1}
      expect(response.code).to eq("200")
    end

    it "access create" do
      post :create, {:post => {some: :attribute}}
      expect(response.code).to eq("200")
    end

    it "access update" do
      put :update, {:id => 1, :post => {some: :attribute}}

      expect(response.code).to eq("200")
    end

    it "access destroy" do
      delete :destroy, {:id => 1}

      expect(response.code).to eq("200")
    end
  end
end
