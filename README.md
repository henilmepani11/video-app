# video_app

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


// final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;

// SizedBox(
//   height: 250,
//   child: ListView.separated(
//     shrinkWrap: true,
//     itemCount: 5,
//     itemBuilder: (context, index) {
//       return GestureDetector(
//         onTap: () {
//           // args.videoName =
//           //     args.videosList?[index].videoName;
//           // args.view = args.videosList?[index].totalView;
//           // args.fav =
//           //     args.videosList?[index].totalFavorite;
//           // args.videoLink =
//           //     args.videosList?[index].videoLink;
//           // print(args.videoLink);
//           // categoryVideosController.update();
//         },
//         child: Padding(
//           padding:
//               EdgeInsets.only(bottom: 10, left: 5.w),
//           child: CustomVideoDetailsContainer(
//               valueTrue: true,
//               image:
//                   args.videosList?[index].thumbnail ??
//                       "",
//               fav: args.videosList?[index]
//                       .totalFavorite ??
//                   0,
//               titleText:
//                   args.videosList?[index].videoName ??
//                       "",
//               view: args.videosList?[index].totalView ??
//                   0,
//               isMoreIcon: false),
//         ),
//       );
//     },
//     separatorBuilder:
//         (BuildContext context, int index) {
//       return const SizedBox(height: 3);
//     },
//   ),
// ),