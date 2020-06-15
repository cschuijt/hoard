module CommissionsHelper
  def active_folder(collection, folder)
    if folder == nil
      "0"
    else
      "#{collection.index(folder) + 1}"
    end
  end
end
