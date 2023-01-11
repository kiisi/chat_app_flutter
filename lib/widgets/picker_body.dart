import 'package:flutter/material.dart';
import 'package:chat_app/repo/image_repository.dart';
import 'package:chat_app/models/image_model.dart';

class NetworkImagePickerBody extends StatelessWidget {
  final Function(String) onImageSelected;

  NetworkImagePickerBody({required this.onImageSelected});

  ImageRepository _imageRepo = ImageRepository();

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24.0),
            topRight: Radius.circular(24.0),
          ),
        ),
        child: FutureBuilder<List<PixelFordImage>>(
          future: _imageRepo.getNetworkImages(),
          builder: (BuildContext context,
              AsyncSnapshot<List<PixelFordImage>> snapshot) {
            if (snapshot.hasData) {
              return GridView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                      onTap: () {
                        onImageSelected(snapshot.data![index].urlSmallSize);
                      },
                      child: Image.network(snapshot.data![index].urlSmallSize));
                },
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  crossAxisSpacing: 2,
                  mainAxisSpacing: 2,
                  maxCrossAxisExtent: MediaQuery.of(context).size.width * 0.5,
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("This is the error: ${snapshot.error}"),
                ),
              );
            }
            return Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(child: CircularProgressIndicator()));
          },
        ));
  }
}
