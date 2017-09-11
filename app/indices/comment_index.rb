ThinkingSphinx::Index.define :comment, with: :active_record do

  indexes content
  indexes user.email, as: :author, sortable: true

end
