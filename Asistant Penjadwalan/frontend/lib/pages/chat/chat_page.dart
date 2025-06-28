// lib/pages/chat_page.dart
import 'package:flutter/material.dart';
import '../../services/chat_service.dart';

class ChatPage extends StatefulWidget {
  final int userId;

  const ChatPage({super.key, required this.userId});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final ChatService _chatService = ChatService();
  final TextEditingController _messageController = TextEditingController();
  final List<ChatMessage> _messages = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _addSystemMessage("Halo! Saya asisten jadwal kuliah Anda. Silakan tanyakan jadwal Anda.");
  }

  void _addSystemMessage(String text) {
    setState(() {
      _messages.insert(0, ChatMessage(
        text: text,
        isUser: false,
        timestamp: DateTime.now(),
      ));
    });
  }

  Future<void> _sendMessage() async {
    final message = _messageController.text.trim();
    if (message.isEmpty || _isLoading) return;

    // Add user message
    setState(() {
      _messages.insert(0, ChatMessage(
        text: message,
        isUser: true,
        timestamp: DateTime.now(),
      ));
      _messageController.clear();
      _isLoading = true;
    });

    try {
      final response = await _chatService.sendMessage(widget.userId, message);
      
      // Add AI response
      setState(() {
        _messages.insert(0, ChatMessage(
          text: response['message'] ?? 'Maaf, terjadi kesalahan',
          isUser: false,
          timestamp: DateTime.now(),
          data: response['data'],
        ));
      });
    } catch (e) {
      setState(() {
        _messages.insert(0, ChatMessage(
          text: 'Error: $e',
          isUser: false,
          timestamp: DateTime.now(),
        ));
      });
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Widget _buildMessage(ChatMessage message) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: message.isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!message.isUser)
            const CircleAvatar(
              radius: 16,
              child: Icon(Icons.school, size: 18),
            ),
          const SizedBox(width: 8),
          Flexible(
            child: Column(
              crossAxisAlignment: message.isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: message.isUser
                        ? Theme.of(context).primaryColor.withOpacity(0.1)
                        : Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(message.text),
                ),
                if (message.data != null && message.data!['schedules'] != null)
                  _buildScheduleCards(message.data!['schedules']),
              ],
            ),
          ),
          if (message.isUser) const SizedBox(width: 8),
          if (message.isUser)
            const CircleAvatar(
              radius: 16,
              child: Icon(Icons.person, size: 18),
            ),
        ],
      ),
    );
  }

  Widget _buildScheduleCards(List<dynamic>? schedules) {
    if (schedules == null || schedules.isEmpty) {
      return const SizedBox.shrink(); // Return empty widget if no schedules
    }

    return Column(
      children: schedules.map((schedule) => Card(
        margin: const EdgeInsets.only(top: 8),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                schedule['nama_matkul'] ?? 'Mata Kuliah',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text('Kode: ${schedule['kode_matkul'] ?? '-'}'),
              Text('Hari: ${schedule['hari_indonesia'] ?? schedule['hari'] ?? '-'}'),
              Text('Waktu: ${schedule['waktu'] ?? '-'}'),
              Text('Dosen: ${schedule['dosen'] ?? '-'}'),
              Text('Kelas: ${schedule['kelas'] ?? '-'}'),
              Text('SKS: ${schedule['sks'] ?? '-'}'),
            ],
          ),
        ),
      )).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Asisten Jadwal Kuliah'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              padding: const EdgeInsets.only(top: 16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return _buildMessage(_messages[index]);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Tanyakan jadwal Anda...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 16),
                    ),
                    onSubmitted: (_) => _sendMessage(),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).primaryColor,
                  ),
                  child: IconButton(
                    icon: _isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : const Icon(Icons.send, color: Colors.white),
                    onPressed: _isLoading ? null : _sendMessage,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChatMessage {
  final String text;
  final bool isUser;
  final DateTime timestamp;
  final Map<String, dynamic>? data;

  ChatMessage({
    required this.text,
    required this.isUser,
    required this.timestamp,
    this.data,
  });
}