json.array!(@books) do |book|
  json.extract! book, :id
  json.title book.title
  json.author book.author
end
