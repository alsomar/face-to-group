def face_to_group
  # Retrieve the selected entities
  model = Sketchup.active_model
  # Start an operation to handle undo/redo
  model.start_operation("Face to group", true)
  # Get the selection set
  selection = model.selection
  # Create an array to hold the selected faces
  faces = []
  # Iterate over the selected entities
  selection.each do |entity|
    # Add the entity to the faces array if it is a face
    faces << entity if entity.is_a?(Sketchup::Face)
  end
  # Iterate over the selected faces
  faces.each do |face|
    # Create an array to hold the connected entities
    connected = []
    # Add the face to the connected array
    connected << face
    # Add the edges that bound the face to the connected array
    face.edges.each do |edge|
      connected << edge
    end
    # Create a group from the connected entities
    group = model.entities.add_group(connected)
  end
  # Commit the operation to handle undo/redo
  model.commit_operation
end

# Add a menu item for the "Face to group" feature
unless defined?(@loaded)
  #Add a submenu for the "ASM tools"
  submenu = UI.menu("Extensions").add_submenu("ASM Tools")
  #Add a menu item for the "Random Colors" feature
  submenu.add_item("Face to group") do
    #When the menu item is clicked, execute the command.
    self.face_to_group()
  end
  #Set the @loaded variable to indicate that the menu item has been added
  @loaded = true
end
