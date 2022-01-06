import 'package:fseg_sousse/components/toast.dart';
import 'package:fseg_sousse/services/auth/authentication.dart';

class ResetPasswordViewModel{


  static resetPassword({required String email})async{
    String? result = await  FireAuth.resetPassword(email: email);
    if (result=="success"){
      ShowToast.toastWarning(content: "A password sent link has been sent to $email");
    }else{
      ShowToast.toastError(content: result!);
    }
  }
}