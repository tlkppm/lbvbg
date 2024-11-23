extends Node

var url = "ws://127.0.0.1:8888"
var ws = WebSocketPeer.new()
func _ready():
	connect_server()
	pass

func _process(delta):
	pass

#发起连接
func connect_server():
	ws.connect_to_url(url)
		

#接收数据包
func receive():
	ws.poll()
	var state = ws.get_ready_state()
	if state == WebSocketPeer.STATE_OPEN:
		while ws.get_available_packet_count():
			var packet = ws.get_packet()
			var data = packet # 获取PackedByteArray
			var text = data.get_string_from_utf8()
			print("数据包：", text)
			sends(text)
			return(text)
#发送数据包
func sends(packet : String):
	ws.send_text(packet)

#判断是否断开，若断开就连接，可放在每帧调用内
func _connect():
	var states = ws.get_ready_state()
	if states == WebSocketPeer.STATE_CLOSED:
		connect_server()
	else:
		pass

