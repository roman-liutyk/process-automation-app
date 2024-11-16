enum UserRoleEnum {
  owner,
  teamManager,
  member;

  factory UserRoleEnum.fromString(String role) {
    switch (role) {
      case 'OWNER':
        return owner;
      case 'TEAM_MANAGER':
        return teamManager;
      case 'MEMBER':
        return member;
      default:
        throw Exception('Provided user role does not exist.');
    }
  }

  @override
  String toString() {
    switch (this) {
      case owner:
        return 'OWNER';
      case teamManager:
        return 'TEAM_MANAGER';
      case member:
        return 'MEMBER';
      default:
        throw Exception('Provided user role does not exist.');
    }
  }

  String get title {
    switch (this) {
      case owner:
        return 'Owner';
      case teamManager:
        return 'Team manager';
      case member:
        return 'Member';
      default:
        throw Exception('Provided user role does not exist.');
    }
  }
}
