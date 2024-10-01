import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news_app/News_ViewMdoel/news_view_model.dart';
import 'package:news_app/models/news_category_model.dart';
import 'package:news_app/view/home_screen.dart';
import 'package:news_app/view/news_detail_screen.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  NewsViewModel newsViewModel = NewsViewModel();
  final format = DateFormat('yyyy-MM-dd ');
  String categoryName = 'general';

  List<String> categoryList = [
    'General',
    'Entertainment',
    'Health',
    'Sports',
    'Bussiness',
    'Technology',
  ];

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height * 1;
    final width = MediaQuery.sizeOf(context).width * 1;
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categoryList.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      categoryName = categoryList[index];
                      setState(() {});
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          color: categoryName == categoryList[index]
                              ? Colors.grey.withOpacity(0.3)
                              : Colors.orange,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Center(
                              child: Text(
                            categoryList[index].toString(),
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          )),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Expanded(
              child: FutureBuilder<CategoryModel>(
                future: newsViewModel.fetchCategoriesNewsApi(categoryName),
                builder: (BuildContext context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: SpinKitCircle(
                        size: 40,
                        color: Colors.orange,
                      ),
                    );
                  } else {
                    // return Container();
                    return ListView.builder(
                      itemCount: snapshot.data!.articles!.length,
                      itemBuilder: (context, index) {
                        DateTime dateTime = DateTime.parse(snapshot
                            .data!.articles![index].publishedAt
                            .toString());
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: CachedNetworkImage(
                                  imageUrl: snapshot
                                      .data!.articles![index].urlToImage
                                      .toString(),
                                  fit: BoxFit.cover,
                                  height: height * 0.18,
                                  width: width * .3,
                                  placeholder: (context, url) => Container(
                                    color: Colors.transparent,
                                    child: const SpinKitFadingCircle(
                                      color: Colors.amber,
                                      size: 50,
                                    ),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ),
                              ),
                              Expanded(
                                  child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => NewsDetailScreen(
                                        newsImage: snapshot
                                            .data!.articles![index].urlToImage
                                            .toString(),
                                        newsTitle: snapshot
                                            .data!.articles![index].title
                                            .toString(),
                                        newsDate: snapshot
                                            .data!.articles![index].publishedAt
                                            .toString(),
                                        author: snapshot
                                            .data!.articles![index].author
                                            .toString(),
                                        description: snapshot
                                            .data!.articles![index].description
                                            .toString(),
                                        source: snapshot
                                            .data!.articles![index].source!.name
                                            .toString(),
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  height: height * 0.18,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15, top: 10),
                                    child: Column(
                                      children: [
                                        Text(
                                          snapshot.data!.articles![index].title
                                              .toString(),
                                          maxLines: 3,
                                          style: GoogleFonts.poppins(
                                            fontSize: 15,
                                            color: Colors.black54,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        Spacer(),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              snapshot.data!.articles![index]
                                                  .source!.name
                                                  .toString(),
                                              maxLines: 3,
                                              style: GoogleFonts.poppins(
                                                fontSize: 15,
                                                color: Colors.black54,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            Text(
                                              format.format(dateTime),
                                              style: GoogleFonts.poppins(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ))
                            ],
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
