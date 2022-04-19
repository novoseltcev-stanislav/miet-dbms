import matplotlib.pyplot as plt
import numpy as np
from sqlalchemy import create_engine


def draw_pie(engine, axis):
    with open('sql/ages.sql') as fd:
        ages_cursor = engine.execute(fd.read())

    ages = {name: count for name, count in ages_cursor}

    axis.pie(ages.values(), labels=ages.keys(), autopct='%1.1f%%', startangle=180)
    axis.set_title('Ages')
    axis.axis('equal')


def draw_single_bar(engine, ax):
    with open('sql/ages.sql') as fd:
       ages_cursor = engine.execute(fd.read())

    ages_counts = {name: count for name, count in ages_cursor}
    width = 0.35
    x = np.arange(len(ages_counts.keys()))
    ax.bar(x, ages_counts.values(), width)
    ax.set_ylabel('Count')
    ax.set_xticks(x, ages_counts.keys())
    ax.set_title('Ages')
    ax.legend()


def draw_double_bar(engine, ax):
    with open('sql/men_ages.sql') as fd:
        men_ages_cursor = engine.execute(fd.read())

    with open('sql/female_ages.sql') as fd:
        female_ages_cursor = engine.execute(fd.read())

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


def draw_result_pie(engine, axis):
    with open('sql/procedures.sql') as fd:
        procedures_cursor = engine.execute(fd.read())

    procedures = {name: count for name, count in procedures_cursor}

    axis.pie(procedures.values(), labels=procedures.keys(), autopct='%1.1f%%', startangle=180)
    axis.set_title('Avg procedures by ages')
    axis.axis('equal')


if __name__ == '__main__':
    DB_URI = 'postgresql+psycopg2://postgres:postgres@localhost:5432/miet_lab2'
    engine = create_engine(DB_URI)
    figure, axis = plt.subplots(2, 2)
    draw_pie(engine, axis[0][0])
    draw_single_bar(engine, axis[0][1])
    draw_double_bar(engine, axis[1][0])
    draw_result_pie(engine, axis[1][1])
    plt.show()
