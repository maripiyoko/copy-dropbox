crumb :root do
  link "CopyDropBox", root_path
end

crumb :folder do |folder|
  link folder.name, folder_path(folder)
  unless folder.parent_folder.nil?
    parent :folder, folder.parent_folder
  end
end

crumb :folder_file do |folder_file|
  link folder_file.name, folder_folder_file_path(folder_file.folder, folder_file)
  unless folder_file.folder.nil?
    parent :folder, folder_file.folder
  end
end
