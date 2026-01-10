enum BookingAction { edit, cancel, reject, reviewRate , isFinal }

class BookingStateMachine {
  static const Map<String, Set<BookingAction>> rules = {
    'pending': {
      BookingAction.edit,
      BookingAction.cancel,
      BookingAction.reject,
    },
    'confirmed': {
      BookingAction.edit,
    },
    'completed': {
      BookingAction.reviewRate,
      BookingAction.isFinal,
    },
    'cancelled': {
      BookingAction.isFinal
    },
    'rejected': {
      BookingAction.isFinal
    },
  };

  static bool can(String status, BookingAction action) {
    return rules[status]?.contains(action) ?? false;
  }
}

