ThinkingSphinx::Index.define :answer, with: :active_record do

  indexes content
  indexes user.email, as: :author

end
