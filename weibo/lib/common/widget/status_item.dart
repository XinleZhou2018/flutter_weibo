import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_parsed_text/flutter_parsed_text.dart';
import 'package:video_player/video_player.dart';
import 'package:weibo/models/status.dart';
import 'package:weibo/utils/log_util.dart';
import 'package:weibo/utils/object_util.dart';

class StatusItem extends StatefulWidget {
  final Status status;

  const StatusItem({super.key, required this.status});

  @override
  State<StatefulWidget> createState() {
    return _StatusItemState();
  }
}

class _StatusItemState extends State<StatusItem> {
  VideoPlayerController? _controller;

  @override
  void initState() {
    LogUtil.v("---------Item InitState---------");

    super.initState();

    if (widget.status.type == 2 &&
        !ObjectUtil.isEmptyString(widget.status.videoUrl)) {
      _controller = VideoPlayerController.network(widget.status.videoUrl!)
        ..initialize().then((value) {
          setState(() {});

          _controller!.play();
        });
    } else {
      _controller = null;
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Widget _renderAuthorWidget() {
    return Container(
      padding: EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 15),
      child: Row(
        children: [
          ClipRRect(
              // clipBehavior: Clip.antiAliasWithSaveLayer,
              borderRadius: BorderRadius.circular(22.5),
              child: CachedNetworkImage(
                imageUrl: widget.status.user?.profileImageUrl ?? "",
                width: 45,
                height: 45,
                // imageBuilder: (context, imageProvider) => Container(
                //   decoration: const BoxDecoration(
                //     borderRadius: BorderRadius.all(
                //       Radius.circular(20),
                //     ),
                //     // image: DecorationImage(
                //     //     image: imageProvider,
                //     //     fit: BoxFit.cover,
                //     //     colorFilter:
                //     //         ColorFilter.mode(Colors.red, BlendMode.colorBurn)),
                //   ),
                // ),
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
              )),
          const SizedBox(
            width: 12,
            height: 2,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.status.user?.name ?? '',
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w600)),
              const SizedBox(
                width: 12,
                height: 4,
              ),
              Text(widget.status.createdAt ?? '',
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w400)),
            ],
          )
        ],
      ),
    );
  }

  Widget _renderContentWidget() {
    return Container(
        padding: const EdgeInsets.only(left: 15, right: 15, top: 5),
        child: parsedText(widget.status.text ?? "")
        // Text(widget.status.text ?? "",
        //     style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w400)),
        );
  }

  ParsedText parsedText(String text) {
    return ParsedText(
      text: text,
      style: const TextStyle(
        // height: 1.5,
        fontSize: 15,
        color: Colors.black,
      ),
      parse: <MatchText>[
        MatchText(
            type: ParsedType.URL,
            style: const TextStyle(
              color: Colors.blue,
              fontSize: 15,
            ),
            onTap: (url) async {}),
        MatchText(
            pattern: r"\[(@[^:]+):([^\]]+)\]",
            style: const TextStyle(
              color: Colors.blue,
              fontSize: 15,
            ),
            renderText: ({required String str, required String pattern}) {
              RegExp customRegExp = RegExp(r"\[(@[^:]+):([^\]]+)\]");
              Match match = customRegExp.firstMatch(str)!;

              // print('test test: ${match[1]}');
              // return Container(
              //   padding: EdgeInsets.all(5.0),
              //   color: Colors.amber,
              //   child: Text(match[1]!),
              // );
              //
              return {'display': match[1]!};
            },
            onTap: (url) {
              LogUtil.v(url);

              RegExp customRegExp = RegExp(r"\[(@[^:]+):([^\]]+)\]");
              Match match = customRegExp.firstMatch(url)!;

              // print('userid: ${match[2]}');
            }),
        MatchText(
            pattern: '#.*?#',
            //       pattern: r"\B#+([\w]+)\B#",
            //   pattern: r"\[(#[^:]+):([^#]+)\]",
            style: const TextStyle(
              color: Color(0xff5B778D),
              fontSize: 15,
            ),
            renderText: ({required String str, required String pattern}) {
              Map<String, String> map = Map<String, String>();

              String idStr =
                  str.substring(str.indexOf(":") + 1, str.lastIndexOf("#"));
              String showStr = str
                  .substring(str.indexOf("#"), str.lastIndexOf("#") + 1)
                  .replaceAll(":" + idStr, "");
              map['display'] = showStr;
              map['value'] = idStr;
              //   print("正则:"+str+"---"+idStr+"--"+startIndex.toString()+"--"+str.lastIndexOf("#").toString());

              return map;
            },
            onTap: (url) async {
              LogUtil.v(url);
            }),
        MatchText(
            pattern: '\\[+emoji-[a-zA-Z]+\\]',

            // pattern: '(\\[/).*?(\\])',
            //       pattern: r"\B#+([\w]+)\B#",
            //   pattern: r"\[(#[^:]+):([^#]+)\]",
            // style: TextStyle(
            //   fontSize: 15,
            // ),
            // renderText: ({required String str, required String pattern}) {
            //   Map<String, String> map = Map<String, String>();
            //   print("表情的正则:" + str);
            //   String mEmoji2 = "";
            //   try {
            //     String mEmoji = str.replaceAll(RegExp('(\\[/)|(\\])'), "");
            //     int mEmojiNew = int.parse(mEmoji);
            //     mEmoji2 = String.fromCharCode(mEmojiNew);
            //   } on Exception catch (_) {
            //     mEmoji2 = str;
            //   }
            //   map['display'] = mEmoji2;

            //   return map;
            // },
            renderWidget: ({required String text, required String pattern}) {
              if (ObjectUtil.isEmptyString(text))
                return const SizedBox.shrink();

              String emojiString =
                  text.substring(1, text.length - 1).split("-")[1];

              return Image.asset("assets/emojis/" + emojiString + ".png",
                  width: 18, height: 18);
            }),
        MatchText(
            pattern: '全文',
            //       pattern: r"\B#+([\w]+)\B#",
            //   pattern: r"\[(#[^:]+):([^#]+)\]",
            style: const TextStyle(
              color: Color(0xff5B778D),
              fontSize: 15,
            ),
            renderText: ({required String str, required String pattern}) {
              Map<String, String> map = Map<String, String>();
              map['display'] = '全文';
              map['value'] = '全文';
              return map;
            },
            onTap: (url) async {}),
      ],
    );
  }

  Widget _renderMediaWidget() {
    //如果没有视频，则先判断有没有转发微博，有就显示转发微博；如果没有则显示9宫格图片（如果有）

    //如果有视频，只显示视频区域
    if (widget.status.type == 2 &&
        !ObjectUtil.isEmptyString(widget.status.videoUrl)) {
      return _controller?.value.isInitialized != null &&
              _controller!.value.isInitialized == true
          ? Container(
              padding: EdgeInsets.only(left: 15, right: 15, top: 15),
              alignment: Alignment.center,
              child: AspectRatio(
                aspectRatio: _controller!.value.aspectRatio,
                child: VideoPlayer(_controller!),
              ))
          : Container();
    }

    if (widget.status.retweetedStatus != null) {
      String text = (widget.status.retweetedStatus?.text ?? '');
      return Container(
        color: const Color.fromRGBO(240, 240, 240, 1),
        width: double.infinity,
        margin: EdgeInsets.only(top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //文字内容区域
            Container(
              padding: const EdgeInsets.only(
                  left: 15, right: 15, top: 10, bottom: 15),
              child: parsedText(text),
            ),
            //图片区域，如果有
            !ObjectUtil.isEmptyList(widget.status.retweetedStatus?.picUrls)
                ? Container(
                    padding:
                        const EdgeInsets.only(left: 15, right: 15, bottom: 15),
                    child: GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount:
                            widget.status.retweetedStatus!.picUrls!.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3, //每行三列
                          childAspectRatio: 1, //显示区域宽高相等
                          mainAxisSpacing: 6,
                          crossAxisSpacing: 6,
                        ),
                        itemBuilder: (context, index) {
                          Map? picUrlMap =
                              widget.status.retweetedStatus!.picUrls![index];
                          return CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl: picUrlMap!["thumbnail_pic"],
                            placeholder: (context, url) =>
                                const CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          );
                        }),
                  )
                : const SizedBox.shrink()
          ],
        ),
      );
    }

    if (!ObjectUtil.isEmptyList(widget.status.picUrls)) {
      return Container(
        padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
        child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: widget.status.picUrls!.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, //每行三列
              childAspectRatio: 1, //显示区域宽高相等
              mainAxisSpacing: 6,
              crossAxisSpacing: 6,
            ),
            itemBuilder: (context, index) {
              Map? picUrlMap = widget.status.picUrls![index];
              return CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: picUrlMap!["thumbnail_pic"],
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              );
            }),
      );
    }

    return const SizedBox.shrink();
  }

  Widget _renderSeparatorLine() {
    return Container(
      margin: const EdgeInsets.only(top: 15),
      width: double.infinity,
      height: 1,
      color: const Color.fromRGBO(230, 230, 230, 1),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _renderAuthorWidget(),
          _renderContentWidget(),
          _renderMediaWidget(),
          _renderSeparatorLine()
        ],
      ),
    );
  }
}
