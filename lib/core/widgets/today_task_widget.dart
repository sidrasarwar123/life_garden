import 'package:flutter/material.dart';
import 'package:life_garden/core/model/task_model.dart';
import 'package:life_garden/core/theme/app_colors.dart';
import 'package:life_garden/core/theme/app_spacing.dart';

class TodayTasksWidget extends StatefulWidget {
  const TodayTasksWidget({super.key});

  @override
  State<TodayTasksWidget> createState() => _TodayTasksWidgetState();
}

class _TodayTasksWidgetState extends State<TodayTasksWidget> {
final List<TaskModel> _tasks = [
  TaskModel(title: 'Read Book', xp: 10, coins: 10, isDone: true),
  TaskModel(title: 'Exercise', xp: 10, coins: 10, isDone: false),
  TaskModel(title: 'Flutter Course', xp: 10, coins: 10, isDone: false),
];
 
  
  @override
  Widget build(BuildContext context) {
    return _buildTodaysTasks();
  }

  Widget _buildTodaysTasks() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Today's Tasks",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.sm + 2, vertical: AppSpacing.xs + 2),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(AppSpacing.buttonRadius),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(Icons.add, color: Colors.white, size: 14),
                    SizedBox(width: 2),
                    Text(
                      'Add Task',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        Container(
          decoration: BoxDecoration(
            color: AppColors.cardBg,
            borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: List.generate(_tasks.length, (i) {
              final task = _tasks[i];
              final isLast = i == _tasks.length - 1;
              return Column(
                children: [
                  _buildTaskTile(task, i),
                  if (!isLast)
                    const Divider(
                      height: 1,
                      indent: 56,
                      color: AppColors.divider,
                    ),
                ],
              );
            }),
          ),
        ),
      ],
    );
  }

  Widget _buildTaskTile(TaskModel task, int index) {
    return InkWell(
      borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
      onTap: () {
        setState(() {
          _tasks[index] = TaskModel(
            title: task.title,
            xp: task.xp,
            coins: task.coins,
            isDone: !task.isDone,
          );
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md, vertical: AppSpacing.sm + 4),
        child: Row(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: task.isDone ? AppColors.taskChecked : Colors.transparent,
                border: Border.all(
                  color: task.isDone ? AppColors.taskChecked : AppColors.taskUnchecked,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(6),
              ),
              child: task.isDone
                  ? const Icon(Icons.check_rounded, color: Colors.white, size: 16)
                  : null,
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.title,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: task.isDone
                          ? AppColors.textSecondary
                          : AppColors.textPrimary,
                      decoration: task.isDone
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      Text(
                        '+${task.xp} XP',
                        style: const TextStyle(
                          fontSize: 11,
                          color: AppColors.primary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Text(
                        '  •  ',
                        style: TextStyle(fontSize: 11, color: AppColors.textMuted),
                      ),
                      Text(
                        '+${task.coins} Coins',
                        style: const TextStyle(
                          fontSize: 11,
                          color: AppColors.coinGold,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Text('🪴', style: TextStyle(fontSize: 20)),
            const SizedBox(width: AppSpacing.xs),
            const Icon(Icons.chevron_right_rounded,
                color: AppColors.textMuted, size: 20),
          ],
        ),
      ),
    );
  }
}

