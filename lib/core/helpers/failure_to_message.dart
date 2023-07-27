// import '../constants/messages.dart';
// import '../errors/failures.dart';

// class FailureToMessage{
//    String mapFailureToMessage(Failure failure) {
//     switch (failure.runtimeType) {
//       case BadRequestFailure:
//         return BadRequest_MESSAGE;
//       case UnauthorizedFailure:
//         return Unauthorized_MESSAGE;
//       case ForbiddenFailure:
//         return Forbidden_MESSAGE;
//       case NotFoundFailure:
//         return NotFound_MESSAGE;
//       case InternalServerErrorFailure:
//         return InternalServerError_MESSAGE;
//       case UnexpectedFailure:
//         return UnexpectedException_MESSAGE;
//       case WrongDataFailure:
//         return WrongData_MESSAGE;
//       case OfflineFailure:
//         return Offline_MESSAGE;
//       case EmptyCacheFailure:
//         return EmptyCache_MESSAGE;
//        default:
//         return "Unexpected Error , Please try again later .";
//     }
//   }
// }