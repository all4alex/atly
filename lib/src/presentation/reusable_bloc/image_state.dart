import 'package:equatable/equatable.dart';

abstract class ImageState extends Equatable {
  const ImageState();

  @override
  List<Object> get props => [];
}

class ImageInitial extends ImageState {}

class ImageLoading extends ImageState {}

class ImageLoaded extends ImageState {
  final String imageURL;

  const ImageLoaded({required this.imageURL});

  @override
  List<Object> get props => [imageURL];
}

class ImageError extends ImageState {}
