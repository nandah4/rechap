import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rechap/di/chat_di.dart';
import 'package:rechap/features/chat/domain/entities/message_entity.dart';

final getMessagesProvider = StreamProvider.autoDispose
    .family<List<MessageEntity?>, String>((ref, conversationId) {
      final messageRepository = ref.read(messageRepositoryProvider);

      return messageRepository.getMessages(conversationId);
    });
