extends Control

@onready var input1 = $VBoxContainer/Input1
@onready var input2 = $VBoxContainer/Input2
@onready var label_resultado = $VBoxContainer/LabelResultado
@onready var label_info = $VBoxContainer/LabelInfo
@onready var vbox_historico = $VBoxContainer/VBoxHistorico

var cor_sucesso = Color(0.2,0.8,0.4)
var cor_erro = Color(1.0,0.3,0.3)
var cor_normal = Color(1.0,1.0,1.0)
var conta_historico = []




# -- auxiliares -- #
func pegar_numeros():
	var texto1 = input1.text
	var texto2 = input2.text
	
	if not texto1.is_valid_float() or not texto2.is_valid_float():
		mostrar_erro("❌ Erro: insira apenas números válidos nos dois campos!")
		return null
	
	return [texto1.to_float(), texto2.to_float()]

func mostrar_resultado(resultado: float, operacao: String) -> void:
	label_resultado.text = "Resultado: "+ str(resultado)
	label_resultado.add_theme_color_override("font_color", cor_sucesso)
	label_info.text = "✅ Operação realizada: " + operacao
	label_info.add_theme_color_override("font_color", cor_sucesso)
	
func mostrar_erro(mensagem: String) -> void:
	label_resultado.text = "Resultado: --"
	label_resultado.add_theme_color_override("font_color", cor_erro)
	label_info.text = mensagem
	label_info.add_theme_color_override("font_color", cor_erro)

func guardar_historico(conta: String, resultado: float) -> void:
	var string_conta = conta + " = " + str(resultado)
	conta_historico.append(string_conta)
	
	if len(conta_historico) > 5:
		conta_historico.remove_at(0)
	
	atualizar_historico()

func atualizar_historico() -> void:
	for c in vbox_historico.get_children(): c.queue_free()
	for conta in conta_historico:
		var conta_label = Label.new()
		conta_label.text = conta
		conta_label.scale = Vector2.ZERO
		
		vbox_historico.add_child(conta_label)







# -- botoes -- #
func _on_btn_soma_pressed() -> void:
	var nums = pegar_numeros()
	if nums == null: return
	
	var expressao = str(nums[0]) + " + " + str(nums[1])
	var conta = nums[0] + nums[1]
	mostrar_resultado(conta, "Soma (+)")
	guardar_historico(expressao, conta)
	
func _on_btn_subtracao_pressed() -> void:
	var nums = pegar_numeros()
	if nums == null: return
	
	var expressao = str(nums[0]) + " - " + str(nums[1])
	var conta = nums[0] - nums[1]
	mostrar_resultado(conta, "Subtração (-)")
	guardar_historico(expressao, conta)
	
func _on_btn_multiplicacao_pressed() -> void:
	var nums = pegar_numeros()
	if nums == null: return
	
	var expressao = str(nums[0]) + " × " + str(nums[1])
	var conta = nums[0] * nums[1]
	mostrar_resultado(conta, "Multiplicação (×)")
	guardar_historico(expressao, conta)
	
func _on_btn_divisao_pressed() -> void:
	var nums = pegar_numeros()
	if nums == null: return

	if nums[1] == 0.0:
		mostrar_erro("🚫 Erro: não existe divisão por zero!")
		return
	
	var expressao = str(nums[0]) + " ÷ " + str(nums[1])
	var conta = nums[0] / nums[1]
	mostrar_resultado(conta, "Divisão (÷)")
	guardar_historico(expressao, conta)
	
func _on_btn_porcentagem_pressed() -> void:
	var nums = pegar_numeros()
	if nums == null: return

	var expressao = str(nums[1]) + "% de " + str(nums[0])
	var conta = nums[0] * (nums[1]/100)
	mostrar_resultado(conta, "Porcentagem (%)")
	guardar_historico(expressao, conta)

func _on_btn_clear_pressed() -> void:
	input1.text = ""
	input2.text = ""
	label_resultado.text = "Resultado: --"
	label_info.text = "Digite os números e escolha uma operação."
	label_resultado.add_theme_color_override("font_color", cor_normal)
	label_info.add_theme_color_override("font_color", cor_normal)
