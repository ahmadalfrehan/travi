class PageViewModel {
  final String image;
  final String text1;
  final String text2;

  PageViewModel(this.image, this.text1, this.text2);
}

List ofPageViewModel = [
  PageViewModel("assets/images/pageview1.jpg", 'Discover More',
      "Travel is the only thing you buy that makes you richer"),
  PageViewModel("assets/images/pageview2.jpg", "Get your freedom",
      'Traveling – it leaves you speechless, then turns you into a storyteller'),
  PageViewModel("assets/images/ahmad.jpg", 'Find your next destination',
      'Tourists don’t know where they’ve been, travelers don’t know where they’re going'),
  PageViewModel('assets/images/pageview4.jpg', "Travel Now",
      "Tourists don't know where they've been, travelers don't know where they've going "),
];
