extends Label

func _process(_delta):
	 text += "Scene Tree Nodes: %d\n" % get_tree().get_node_count()
