crumb :root do
  link "CopyDropBox", root_path
end

crumb :folder do |folder|
  link folder.name, folder_path(folder)
  unless folder.parent_folder.nil?
    parent :folder, folder.parent_folder
  end
end

