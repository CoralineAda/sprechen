module ScopesAndPersistsModel

  def self.included(base)
    base.extend ClassMethods
    base.send(:before_filter, :scope_model, :except => [:index])
    base.send(:before_filter, :persist_model, :only => [:create, :update])
  end

  def persist_model
    @scoped_model.update_attributes(params[symbolized_model_name])
  end

  def handle_errors_on(action)
    @scoped_model.errors.present? && render(action)
  end

  def symbolized_model_name
    base_model.name.downcase.to_sym
  end

  def base_model
    self.class.base_model
  end

  def scope_model
    @scoped_model = params[:id] && base_model.where(:id => params[:id]).first || base_model.new(params[symbolized_model_name])
    instance_variable_set("@#{symbolized_model_name.to_s}", @scoped_model)
  end

  module ClassMethods

    def scopes_and_persists(model_name)
      @base_model = eval(model_name.to_s.classify)
    end

    def base_model
      @base_model
    end

  end

end