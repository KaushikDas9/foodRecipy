

class RecipieModel {

   late String appLabel;
   late String appImgUrl;
   late double appCalories;
   late String appUrl;
   late String appImage;

   RecipieModel( { this.appCalories=0.00 , this.appImgUrl="Image" , this.appLabel="Label" , this.appUrl="appUrl" } );

   factory RecipieModel.fromMap( Map recipi ) {
         return RecipieModel(
            appLabel: recipi["label"] ,
            appCalories: recipi["calories"] ,
            appImgUrl: recipi["image"] ,
             appUrl: recipi["url"]
         );
   }
}