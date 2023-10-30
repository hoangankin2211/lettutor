import 'package:lettutor/data/entities/test_preparation.dart';
import 'package:lettutor/data/entities/user_entity.dart';
import 'package:lettutor/data/entities/wallet_info_entity.dart';
import 'package:lettutor/domain/models/models.dart';

import '../../data/entities/user_info_entity.dart';

class UserMapper {
  static User fromEntity(UserEntity userEntity) {
    return User(
      id: userEntity.id,
      email: userEntity.email,
      name: userEntity.name,
      avatar: userEntity.avatar,
      country: userEntity.country,
      phone: userEntity.phone,
      roles: userEntity.roles,
      language: userEntity.language ?? 'en',
      birthday: userEntity.birthday,
      isActivated: userEntity.isActivated,
      courses: userEntity.courses,
      requireNote: userEntity.requireNote,
      level: userEntity.level,
      learnTopics: userEntity.learnTopics,
      isPhoneActivated: userEntity.isPhoneActivated,
      timezone: userEntity.timezone,
      studySchedule: userEntity.studySchedule,
      canSendMessage: userEntity.canSendMessage,
      walletInfo: WalletInfoMapper.fromEntity(userEntity.walletInfo),
      testPreparations: List.of(
        userEntity.testPreparations.map(
          (e) => TestPreparationMapper.fromEntity(e),
        ),
      ),
    );
  }

  static User fromUserInfoEntity(UserData userEntity) {
    return User(
      id: userEntity.id,
      email: userEntity.email,
      name: userEntity.name,
      avatar: userEntity.avatar,
      country: userEntity.country,
      phone: userEntity.phone,
      roles: userEntity.roles,
      language: userEntity.language,
      birthday: userEntity.birthday,
      isActivated: userEntity.isActivated,
      requireNote: userEntity.requireNote,
      level: userEntity.level,
      learnTopics: userEntity.learnTopics,
      isPhoneActivated: userEntity.isPhoneActivated,
      timezone: userEntity.timezone,
      studySchedule: userEntity.studySchedule,
      canSendMessage: userEntity.canSendMessage,
      walletInfo: WalletInfoMapper.fromUserInfoEntity(userEntity.walletInfo),
      testPreparations: List.of(
        userEntity.testPreparations.map(
          (e) => TestPreparationMapper.fromEntity(e),
        ),
      ),
    );
  }
}

class WalletInfoMapper {
  static WalletInfo fromEntity(WalletInfoEntity entity) {
    return WalletInfo(
      id: entity.id,
      userId: entity.userId,
      amount: entity.amount,
      isBlocked: entity.isBlocked,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      bonus: entity.bonus,
    );
  }

  static WalletInfo fromUserInfoEntity(WalletUserInfo entity) {
    return WalletInfo(
      amount: entity.amount,
      isBlocked: entity.isBlocked,
      bonus: entity.bonus,
    );
  }
}

class TestPreparationMapper {
  static TestPreparation fromEntity(TestPreparationEntity entity) {
    return TestPreparation(
      id: entity.id,
      key: entity.key,
      name: entity.name,
    );
  }
}
