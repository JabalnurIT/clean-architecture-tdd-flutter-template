import 'package:equatable/equatable.dart';
import 'package:clean_architecture_tdd_flutter_template/core/res/media_res.dart';

class PageContent extends Equatable {
  const PageContent({
    required this.image,
    required this.title,
    required this.description,
  });

  const PageContent.first()
      : this(
          image: MediaRes.coconutTree,
          title: 'New to Flutter?',
          description: 'Create an amazing application.',
        );
  const PageContent.seccond()
      : this(
          image: MediaRes.polyFawn,
          title: 'Want to use it?',
          description: 'Don\'t wait anymore.',
        );
  const PageContent.third()
      : this(
          image: MediaRes.flutterVectors,
          title: 'Let\'s get started!',
          description: 'You are your own bos.',
        );

  final String image;
  final String title;
  final String description;

  @override
  List<Object?> get props => [title, description, image];
}
