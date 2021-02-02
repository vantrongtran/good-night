# permit and export variable from permited params

module DeclaredParams
  extend ActiveSupport::Concern
  class_methods do
    # permit params each function in controller
    # parameter:
    #   only:
    #     type: Array symbol name of function like [:index, :create]
    #   except:
    #     type: Array symbol is the same with only
    #   params
    #     type: Array symbol name of params you want to permit
    # Use:
    #   permited_params only: [:create], params: [:username, :password]
    def permited_params(only: [], except: [], params: [])
      before_action(only: only, except: except) do
        declared_variables params
      end
    end
  end

  def declared_variables attrs
    @declared_params = attrs

    attrs.each do |p|
      class_eval { attr_reader p }
      instance_variable_set "@#{p}".to_sym, permited_params[p]
    end
  end

  def permited_params
    params.permit @declared_params
  end
end
