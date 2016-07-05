SimpleForm.setup do |config|
  config.wrappers :material, :tag => 'div', :class => 'form-group', :error_class => 'has-error' do |b|
    b.use :html5

    b.use :input, class: "form-control"
    b.use :error,  wrap_with: { tag: :span, class: "help-block" }
    b.use :label
    b.use :hint,  wrap_with: { tag: :p, class: "help-block" }
    b.optional :readonly
  end

  config.default_wrapper = :material
end
