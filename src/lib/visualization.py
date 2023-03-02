import pandas as pd
import plotly.offline as pyoff
import plotly.express as px


def df_animation(df):
    fig = px.scatter(
        data_frame=df,  # 使用するデータフレーム
        x='dim0',  # 横軸の値に設定するデータフレームの列名
        y='dim1',  # 縦軸に設定するデータフレームの列名
        color='label',  # 色を区別する列名
        hover_data=df,
        animation_frame='step', 
    )
    fig.update_layout(
        width=500, 
        height=500,
        xaxis = dict(title="dim0", range = [-40,40], dtick=10),   
        yaxis = dict(title="dim1", range = [-40,40], dtick=10, scaleanchor='x')
    )
    fig.update_layout(coloraxis_showscale=False)
    pyoff.iplot(fig)
    
    
def visualize_time_series_df(visible_coords_df, info_df):
    """
    visible_coords_df： 座標情報が入っている dataframe
    info_df：　ラベル情報などメタ情報が入っている dataframe
    
    info_df = pd.DataFrame(
        data={
            'label': labels,
            'type': types
        }
    )
    """
        
    df = pd.concat([visible_coords_df, info_df], axis=1)
    df_animation(df)
    
