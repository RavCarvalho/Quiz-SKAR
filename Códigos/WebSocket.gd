extends Node

var txt = ""
var client
var connected: bool = false

#const ip = "192.168.101.212"
const ip = "192.168.43.92"

const port = 80
var ledstate: int;
var keys: Dictionary = {
	'B1': false,
	'B2': false
}

# Sinais de cada botao
signal azul(Menu, Tutorial, Information, QuizMain, FimDeJogo, SceneEqueipe);
signal vermelho(Menu, Tutorial, Information, QuizMain, FimDeJogo, SceneEqueipe);
signal botaoA(Menu, Tutorial, Information, QuizMain, FimDeJogo, SceneEqueipe);
signal botaoB(Menu, Tutorial, Information, QuizMain, FimDeJogo, SceneEqueipe);
signal botaoC(Menu, Tutorial, Information, QuizMain, FimDeJogo, SceneEqueipe);
signal zero(Menu, Tutorial, Information, QuizMain, FimDeJogo, SceneEqueipe)

func _ready():
	client = StreamPeerTCP.new()
	client.connect_to_host(ip, port)
	if(client.is_connected_to_host()):
		connected = true
		print("Conectado")

		
func _process(delta):
	if connected and not client.is_connected_to_host():
		connected = false
	else:
		_readWebSocket()
		
func _readWebSocket():
	while client.get_available_bytes()>0:
		var message = client.get_utf8_string(client.get_available_bytes())
		print(txt)
		if message == null:
			continue
		elif message.length()>0:
			
			for i in message:
				if i =='\n':
					_messageInterpreter(txt)
					txt = ''
				else:
					txt += i

func _writeWebsocket(txt):
	if connected and client.is_connected_to_host():
		client.put_data(txt.to_ascii())
					
func _messageInterpreter(txt):		
	var command = txt.split(' ')
	# Avaliação das mensagens recebidas (ada botão emite um sinal diferente)
	if command.size() == 2:
		print("grande")
		if command[0] == "B1" :
			keys.B1 = true
			emit_signal("azul");
			print("azul apertado")
			
		if command[0] == "B2":
			emit_signal("vermelho");
			print("vermelho apertado")
			keys.B2 = true
			
		if command[0] == "A":
			emit_signal("botaoA");
			print("a apertou")
			
		if command[0] == "B":
			emit_signal("botaoB");
			print("b apertou")
			
		if command[0] == "C":
			emit_signal("botaoC");
			print("c apertou")
		if command[0] == "A0":
			emit_signal("zero");
			
#	if connected == true:
#		print("Conexão estabelecida")
