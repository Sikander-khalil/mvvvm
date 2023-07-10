
import 'package:flutter/material.dart';
import 'package:mvvvm/data/response/status.dart';
import 'package:mvvvm/model/movies_model.dart';
import 'package:mvvvm/utilis/routes/routes_name.dart';
import 'package:mvvvm/utilis/utilis.dart';
import 'package:mvvvm/view_model/home_view_model.dart';
import 'package:mvvvm/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeViewModel homeViewModel = HomeViewModel();

  @override
  void initState() {
    // TODO: implement initState
    homeViewModel.fetchMoviesListApi();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final userPreference = Provider.of<UserViewModel>(context);
    return Scaffold(
      appBar: AppBar(

        automaticallyImplyLeading: false,
        actions: [

          InkWell(
            onTap: (){

              userPreference.remove().then((value) {

                Navigator.pushNamed(context, RoutesName.login);


              }).onError((error, stackTrace){



              });
            },
            child: const Text("Logout"),
          ),
          const SizedBox(width: 20,)

        ],


      ),
      body: ChangeNotifierProvider<HomeViewModel>(
        create: (BuildContext context) => homeViewModel,

        child: Consumer<HomeViewModel>(

            builder: (context, value, _) {

              switch(value.moviesList){

                case Status.LOADING:

                  return Center(child: CircularProgressIndicator());
                case Status.ERROR:
                  return Center(child: Text(value.moviesList.message.toString()));

                case Status.COMPLETED:
                  return ListView.builder(
                      itemCount: value.moviesList.data!.movies!.length,
                      itemBuilder: (context, index){
                    return Card(
                      child: ListTile(

                        leading: Image.network(value.moviesList.data!.movies![index].posterurl.toString(),
                        errorBuilder: (context, error, stack){

                          return Icon(Icons.error, color: Colors.red,);

                      },
                          height: 40,
                          width: 40,
                          fit: BoxFit.cover,

                        ),

                        title: Text(value.moviesList.data!.movies![index].title.toString()),
                        subtitle: Text(value.moviesList.data!.movies![index].year.toString()),
                        trailing: Row(

                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(Utilis.averageRating(value.moviesList.data!.movies![index].ratings!).toStringAsFixed(1)),
                          ],
                        ),
                      ),
                    );
                  });
              }

              return Container(


              );




    })


      )
    );
  }
}
