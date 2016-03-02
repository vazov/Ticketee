module Admin::PermissionHelper
  def permissions
	{ "view" => "View",
	"create tickets" => "Create Tickets",
	"edit tickets" => "Edit Tickets",
    "delete tickets" => "Delete Tickets" }
  end
end
