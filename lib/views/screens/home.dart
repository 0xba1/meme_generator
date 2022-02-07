import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:meme_generator/controllers/meme_provider.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MemeProvider memeProvider = Provider.of<MemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Meme Generator"),
      ),
      body: Center(
        child: getWidget(memeProvider),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Text(
          "🚀",
          style: TextStyle(fontSize: 24),
        ),
        onPressed: Provider.of<MemeProvider>(context, listen: false).getMeme,
      ),
    );
  }
}

Widget getWidget(MemeProvider memeProvider) {
  if (memeProvider.badIntenet) {
    debugPrint("6666666666666666666666666666666666666666");
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.signal_wifi_connected_no_internet_4_rounded,
          size: 100,
          color: Colors.grey.withOpacity(0.2),
        ),
        Text(
          'No Internet',
          style: TextStyle(color: Colors.grey.withOpacity(0.2), fontSize: 32),
        )
      ],
    );
  }

  if (memeProvider.isLoading) {
    return const CircularProgressIndicator();
  }

  if (memeProvider.memeIndex != null) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      child: CachedNetworkImage(
          placeholder: (context, url) => const CircularProgressIndicator(),
          imageUrl: memeProvider.memes![memeProvider.memeIndex!]['url']),
    );
  }

  return const SizedBox();
}
