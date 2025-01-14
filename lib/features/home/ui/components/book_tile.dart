import 'package:flutter/material.dart';

class BookTile extends StatelessWidget {
  final String title;
  final String author;
  final String language;
  final String coverImageUrl;
  final VoidCallback onExpand;
  const BookTile({
    Key? key,
    required this.title,
    required this.author,
    required this.language,
    required this.coverImageUrl,
    required this.onExpand,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.brown.shade50,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.brown.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 100,
                  height: 140,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.brown.withOpacity(0.2),
                        blurRadius: 4,
                        offset: const Offset(2, 2),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      coverImageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: Colors.amber.shade100,
                        child: Icon(
                          Icons.book,
                          size: 40,
                          color: Colors.brown.shade300,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.brown.shade900,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        author,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.brown.shade700,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.amber.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          language.toUpperCase(),
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.brown.shade700,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Wrap(
                      //   spacing: 4,
                      //   runSpacing: 4,
                      //   children: bookshelves.map((shelf) {
                      //     return Container(
                      //       padding: const EdgeInsets.symmetric(
                      //         horizontal: 6,
                      //         vertical: 2,
                      //       ),
                      //       decoration: BoxDecoration(
                      //         color: Colors.brown.shade100,
                      //         borderRadius: BorderRadius.circular(4),
                      //       ),
                      //       child: Text(
                      //         shelf,
                      //         style: TextStyle(
                      //           fontSize: 11,
                      //           color: Colors.brown.shade700,
                      //         ),
                      //       ),
                      //     );
                      //   }).toList(),
                      // ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                onExpand();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(
                                    0xFF3E2012), // Coffee brown color
                                foregroundColor:
                                    Colors.amber, // Amber text color
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 8,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Text(
                                'Expand',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
