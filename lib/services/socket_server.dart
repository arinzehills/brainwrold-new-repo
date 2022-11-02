import 'package:socket_io_client/socket_io_client.dart';

class SocketService {
  // Socket socket;
  // SocketService({required this.socket});

  Socket socketServer(socket) {
    //Configure socket Transport
    socket = io("http://localhost:3000", <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });
    socket.connect();
    socket.on('connect', (data) => print('Connected:' + socket.id!));
    return socket;
    // } catch (e) {
    //   print(e.toString());
    // }
  }
}
