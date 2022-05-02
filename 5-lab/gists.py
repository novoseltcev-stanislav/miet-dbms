import matplotlib.pyplot as plt
import numpy as np
from sqlalchemy import create_engine


class Dashboard:
    def __init__(self, DB_URI: str):
        self.engine = create_engine(DB_URI)
        _, self.axis = plt.subplots(2, 2)

    def draw(self):
        self._draw_pie(self.axis[0][0])
        self._draw_single_bar(self.axis[0][1])
        self._draw_double_bar(self.axis[1][0])
        self._draw_result_pie(self.axis[1][1])
        plt.show()

    def _draw_pie(self, ax):
        with open('sql/ages.sql') as fd:
            ages_cursor = self.engine.execute(fd.read())

        ages = {name: count for name, count in ages_cursor}

        ax.pie(ages.values(), labels=ages.keys(), autopct='%1.1f%%', startangle=180)
        ax.set_title('Ages')
        ax.axis('equal')

    def _draw_single_bar(self, ax):
        with open('sql/ages.sql') as fd:
           ages_cursor = self.engine.execute(fd.read())

        ages_counts = {name: count for name, count in ages_cursor}
        width = 0.35
        x = np.arange(len(ages_counts.keys()))
        ax.bar(x, ages_counts.values(), width)
        ax.set_ylabel('Count')
        ax.set_xticks(x, ages_counts.keys())
        ax.set_title('Ages')
        ax.legend()

    def _draw_double_bar(self, ax):
        with open('sql/men_ages.sql') as fd:
            men_ages_cursor = self.engine.execute(fd.read())

        with open('sql/female_ages.sql') as fd:
            female_ages_cursor = self.engine.execute(fd.read())

        men_ages = {name: count for name, count in men_ages_cursor}
        female_ages = {name: count for name, count in female_ages_cursor}

        width = 0.35
        x = np.arange(len(men_ages.keys()))
        ax.bar(x - width / 2, men_ages.values(), width, label='Men')
        ax.bar(x + width / 2, female_ages.values(), width, label='Female')
        ax.set_ylabel('Count')
        ax.set_xticks(x, men_ages.keys())
        ax.set_title('Ages grouped by sex')
        ax.legend()

    def _draw_result_pie(self, ax):
        with open('sql/procedures.sql') as fd:
            procedures_cursor = self.engine.execute(fd.read())

        procedures = {name: count for name, count in procedures_cursor}

        ax.pie(procedures.values(), labels=procedures.keys(), autopct='%1.1f%%', startangle=180)
        ax.set_title('Avg procedures by ages')
        ax.axis('equal')


if __name__ == '__main__':
    dashboard = Dashboard('postgresql+psycopg2://postgres:postgres@localhost:5432/miet_lab2')
    dashboard.draw()
