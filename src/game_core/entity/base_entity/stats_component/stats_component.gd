class_name StatsComponent extends Resource

@export var base_health: float = 100.0
@export var base_movement_speed: float = 10.0
@export var base_jump_force: float = 4.0
@export var base_attack_damage: float = 10.0
@export var base_attack_range: float = 1.0
@export var base_attack_speed: float = 1.0
@export var base_armor: float = 0.0
@export var base_magic_resistance: float = 0.0

var health_stat: HealthStat
var movement_speed_stat: MovementSpeedStat
var jump_force_stat: JumpForceStat
var attack_damage_stat: AttackDamageStat
var attack_range_stat: AttackRangeStat
var attack_speed_stat: AttackSpeedStat
var armor_stat: ArmorStat
var magic_resistance_stat: MagicResistanceStat

func initialize_stats() -> void:
    health_stat = HealthStat.new(base_health)
    movement_speed_stat = MovementSpeedStat.new(base_movement_speed)
    jump_force_stat = JumpForceStat.new(base_jump_force)
    attack_damage_stat = AttackDamageStat.new(base_attack_damage)
    attack_range_stat = AttackRangeStat.new(base_attack_range)
    attack_speed_stat = AttackSpeedStat.new(base_attack_speed)
    armor_stat = ArmorStat.new(base_armor)
    magic_resistance_stat = MagicResistanceStat.new(base_magic_resistance)