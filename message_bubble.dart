import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  // Fields for the MessageBubble widget
  final String? userImage; // User image for the first message in a sequence
  final String? username; // Username for the first message in a sequence
  final String message; // The message content
  final bool isMe; // Whether the message is from the current user
  final bool
      isFirstInSequence; // Whether this message is the first in a sequence

  // Named constructor for the first message in the sequence
  const MessageBubble.first({
    Key? key,
    required this.userImage,
    required this.username,
    required this.message,
    required this.isMe,
  })  : isFirstInSequence = true,
        super(key: key); // Pass the key to the superclass constructor

  // Named constructor for messages that follow in the sequence
  const MessageBubble.next({
    Key? key,
    required this.message,
    required this.isMe,
  })  : isFirstInSequence = false,
        userImage = null,
        username = null,
        super(key: key); // Pass the key to the superclass constructor

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Stack(
      children: [
        if (userImage != null)
          Positioned(
            top: 15,
            // Align user image to the right if the message is from the current user
            right: isMe ? 0 : null,
            child: CircleAvatar(
              backgroundImage: NetworkImage(userImage!),
              backgroundColor: theme.colorScheme.primary.withAlpha(180),
              radius: 23,
            ),
          ),
        Container(
          // Add margin to the edges of the messages to make space for the user's image
          margin: const EdgeInsets.symmetric(horizontal: 46),
          child: Row(
            // Align messages based on whether they are from the current user
            mainAxisAlignment:
                isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment:
                    isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  // Provide visual buffer at the top for the first message
                  if (isFirstInSequence) const SizedBox(height: 18),
                  if (username != null)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 13),
                      child: Text(
                        username!,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  Container(
                    decoration: BoxDecoration(
                      color: isMe
                          ? Colors.grey[300]
                          : theme.colorScheme.secondary.withAlpha(200),
                      borderRadius: BorderRadius.only(
                        topLeft: !isMe && isFirstInSequence
                            ? Radius.zero
                            : const Radius.circular(12),
                        topRight: isMe && isFirstInSequence
                            ? Radius.zero
                            : const Radius.circular(12),
                        bottomLeft: const Radius.circular(12),
                        bottomRight: const Radius.circular(12),
                      ),
                    ),
                    constraints: const BoxConstraints(maxWidth: 200),
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 14),
                    margin:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                    child: Text(
                      message,
                      style: TextStyle(
                        height: 1.3,
                        color: isMe
                            ? Colors.black87
                            : theme.colorScheme.onSecondary,
                      ),
                      softWrap: true,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
