import 'package:final_project/features/agents_feature/domain/entities/agents_entity.dart';
import 'package:final_project/features/agents_feature/domain/use_cases/get_agents_usecase.dart';
import 'package:get/get.dart';

import '../../../../core/errors/fauilers.dart';

class AgentsController extends GetxController{
  GetAgentsUseCase agentsUseCase;
  AgentsController({required this.agentsUseCase});

  AgentsEntity agentsEntity=AgentsEntity(id: 0, name: '', image: '');
  bool  isLoading = false;

  @override
  void onInit() {
    getAgents();
  }
  startLoading() {
    isLoading = true;
    update();
  }

  endLoading() {
    isLoading = false;
    update();
  }


  Future getAgents() async {
    startLoading();
    var response = await agentsUseCase.call();
    endLoading();
    print(response);
    response?.fold((l) {
      ConnectionFailure();
    }, (r) {
     agentsEntity.name=r.name;
     agentsEntity.id=r.id;
     agentsEntity.image=r.image;
    });
    endLoading();
  }


}