
abstract class FormSubmissionStatus {
  const FormSubmissionStatus();
}

class InitialFormStatus extends FormSubmissionStatus {
  const InitialFormStatus();
}

class FormSubmitting extends FormSubmissionStatus {}

class SubmissionSuccess extends FormSubmissionStatus {
  // SubmissionSuccess(BuildContext context) {
  //   Navigator.of(context)
  //       .push(MaterialPageRoute(builder: (_) => MainViewScreen()));
  // }
}

class SubmissionFailed extends FormSubmissionStatus {
  final Exception exception;
  SubmissionFailed(this.exception);
}
