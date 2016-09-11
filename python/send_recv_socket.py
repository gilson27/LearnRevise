"""
	@author Gilson Varghese
	@date September 4 2016
	@description udp socket data send app
"""
import socket

class SocketApp:
	"""
		@constructor to do any initialization if required
	"""
	def __init__(self):
		print("test");
		

	"""
		Method to create socket
	"""
	def create_socket(self, addr):
		self.sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
		self.sock.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
		self.sock.bind((socket.gethostname(), 9998))
	"""
		Method to send message
	"""
	def send_message(self, msg, addr):
		packet = msg.encode('UTF-8')
		self.sock.sendto(packet, addr)
		
	"""
		Method to receive message
	"""
	def recv_msg(self, addr):
		BYTES = 512
		(recvd_msg, addr_tuple) = self.sock.recvfrom(BYTES)
		return recvd_msg 
		
if __name__=="__main__":
	socketObject = SocketApp()
	IP = socket.gethostname()
	PORT = 9998
	MSG = "Hi How are you"
	addr_tuple = (IP, PORT)
	socketObject.create_socket(addr_tuple)
	socketObject.send_message(MSG, addr_tuple);
	recvd_msg = socketObject.recv_msg(addr_tuple);
	print("received message: ", recvd_msg );
