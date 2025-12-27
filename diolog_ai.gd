extends CanvasLayer

signal Dialouge_finished
@onready var name_lable: Label = $Panel/MarginContainer/VBoxContainer/NameLable
@onready var dialouge_lable: Label = $Panel/MarginContainer/VBoxContainer/dialougeLable
@onready var continue_lable: Label = $"Panel/Panel/Continue Lable"
@onready var panel: Panel = $Panel

const CHAR_READ_RATE:float = 0.05
const PUNC_PAUSE:float = 0.02
var _current_dialouge : Array(Dictionary) = []
var _current_page_index : int = 0
var _is_diolauge_active : bool = true
# var _current_page_index : int = 0
