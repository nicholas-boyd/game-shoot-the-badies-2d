extends CanvasLayer

@onready var laser_label: Label = $LaserCounter/VBoxContainer/Label
@onready var grenade_label: Label = $GrenadeCounter/VBoxContainer/Label
@onready var laser_icon: TextureRect = $LaserCounter/VBoxContainer/TextureRect
@onready var grenade_icon: TextureRect = $GrenadeCounter/VBoxContainer/TextureRect
@onready var health_bar: TextureProgressBar = $MarginContainer/TextureProgressBar

# Colors
var green: Color = Color("6bbfa3") #Color(hex color code)
var red: Color = Color(0.9,0,0,1) #Color(red,green,blue,alpha)

func _ready():
	Globals.connect("laser_ammo_change", update_laser_text)
	Globals.connect("grenade_ammo_change", update_grenade_text)
	Globals.connect("health_change", update_health_bar)
	
	# Set initial ammo and health values
	update_laser_text()
	update_grenade_text()
	update_health_bar()

func update_laser_text() -> void:
	laser_label.text = str(Globals.laser_ammo)
	update_color(Globals.laser_ammo, laser_label, laser_icon)

func update_grenade_text() -> void:
	grenade_label.text = str(Globals.grenade_ammo)
	update_color(Globals.grenade_ammo, grenade_label, grenade_icon)

func update_health_bar() -> void:
	health_bar.value = Globals.health

func update_color(amount: int, label: Label, icon: TextureRect) -> void:
	if amount <= 0:
		label.modulate = red
		icon.modulate = red
	else:
		label.modulate = green
		icon.modulate = green
